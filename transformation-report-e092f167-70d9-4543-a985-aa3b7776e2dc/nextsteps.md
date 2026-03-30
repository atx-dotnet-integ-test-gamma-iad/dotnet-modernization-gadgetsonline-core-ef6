# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution. The following steps outline how to validate, test, and deploy the migrated `GadgetsOnline` project.

---

## 1. Restore NuGet Packages

Before running or testing the project, ensure all dependencies are restored correctly.

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages. If any packages targeting the old .NET Framework are present, check NuGet for their cross-platform equivalents.

---

## 2. Build the Solution in Release Mode

Perform a full build in Release configuration to confirm there are no configuration-specific issues.

```bash
dotnet build --configuration Release
```

Ensure the build completes with zero errors and review any warnings, as some warnings may indicate runtime issues.

---

## 3. Review Removed or Replaced APIs

After a legacy migration, some APIs may have been silently replaced or stubbed. Manually review the following areas:

- Any usage of `System.Web` namespaces, which are not available in cross-platform .NET. These should have been replaced with `Microsoft.AspNetCore.*` equivalents.
- `HttpContext`, `HttpRequest`, and `HttpResponse` usages to confirm they reference `Microsoft.AspNetCore.Http` and not legacy types.
- `Global.asax` logic, which should have been migrated to `Program.cs` and/or `Startup.cs` (or the minimal hosting model in .NET 6+).
- `Web.config` settings, which should have been moved to `appsettings.json` and configured via `IConfiguration`.

---

## 4. Run Unit Tests

If the solution contains test projects, execute them to validate core functionality.

```bash
dotnet test
```

Review the test results for any failures that may indicate behavioral differences between the legacy .NET Framework version and the new cross-platform .NET version.

---

## 5. Verify Database Connectivity

If the project uses Entity Framework or direct database access:

- Confirm the connection strings in `appsettings.json` are correct.
- If using Entity Framework, run the following to verify the model against the database:

```bash
dotnet ef database update
```

- Check that the correct EF Core provider package is referenced (e.g., `Microsoft.EntityFrameworkCore.SqlServer`).

---

## 6. Run the Application Locally

Start the application locally and manually verify core functionality.

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

- Navigate through the primary user-facing pages or endpoints.
- Test any authentication or authorization flows.
- Verify that static files (CSS, JavaScript, images) are being served correctly.
- Check that any e-commerce specific flows (product listing, cart, checkout) function as expected given the nature of the project.

---

## 7. Check Middleware and Request Pipeline

Open `Program.cs` (and `Startup.cs` if present) and confirm the middleware pipeline is correctly configured. Key middleware to verify includes:

- `app.UseStaticFiles()`
- `app.UseRouting()`
- `app.UseAuthentication()` and `app.UseAuthorization()` (if applicable)
- `app.UseSession()` (if session state is used)

Ensure middleware is registered in the correct order, as incorrect ordering is a common source of runtime issues after migration.

---

## 8. Review Logging Configuration

Confirm that logging has been properly configured in `appsettings.json` and that the application produces meaningful output during local runs. The legacy `System.Diagnostics` or custom logging implementations should be replaced with `Microsoft.Extensions.Logging`.

---

## 9. Publish the Application

Once local validation is complete, publish the application to confirm the output is correct.

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files, including static assets and configuration files, are present.

---

## 10. Validate the Published Output

Run the published output directly to confirm it behaves identically to the development run.

```bash
dotnet ./publish/GadgetsOnline.dll
```

Perform the same manual validation steps outlined in Step 6 against this published build.