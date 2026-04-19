# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to an appropriate modern .NET version, such as `net8.0`. Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

If it is still referencing `net48` or another legacy framework, update it accordingly and rebuild.

### 4. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the application in a browser and verify that core functionality behaves as expected, including routing, data access, and any authentication flows.

### 5. Execute Existing Tests

If the solution contains test projects, run them to validate that behavior has not regressed:

```bash
dotnet test
```

Review the test results and investigate any failures to determine whether they are caused by the migration or pre-existing issues.

### 6. Check for Removed or Changed APIs

Review the code for usage of APIs that are known to behave differently or have been removed in modern .NET, including:

- `System.Web` namespaces, which are not available outside of ASP.NET on .NET Framework
- `HttpContext` usage patterns that differ between ASP.NET and ASP.NET Core
- Any use of `ConfigurationManager`, which should be replaced with `IConfiguration`
- `Global.asax` application lifecycle hooks, which should be migrated to `Program.cs` or middleware

### 7. Verify Static Files and Configuration

Confirm that static files such as CSS, JavaScript, and images are served correctly. In ASP.NET Core, static files must be placed in the `wwwroot` folder and the middleware must be enabled in `Program.cs`:

```csharp
app.UseStaticFiles();
```

Also verify that `appsettings.json` contains all configuration values that were previously in `Web.config`.

### 8. Review Database Connectivity

If the project uses Entity Framework or direct database connections, confirm that:

- The connection string in `appsettings.json` is correct
- The database provider package targets .NET-compatible versions
- Any migrations are up to date by running:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to confirm the output is correct:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to ensure all required files are present before deploying to the target environment.