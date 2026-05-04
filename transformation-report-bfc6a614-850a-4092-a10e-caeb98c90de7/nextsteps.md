# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in the solution. The project `GadgetsOnline/GadgetsOnline.csproj` compiled without issues.

## Validation

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application's key workflows (e.g., product browsing, cart, checkout if applicable) to confirm runtime behavior is correct.

### 5. Run Existing Tests

If the solution contains test projects, execute them to verify functional correctness:

```bash
dotnet test
```

Review any failing tests and address them before proceeding to deployment.

### 6. Check for Runtime Compatibility Issues

Even with a clean build, certain areas require manual review:

- **Entity Framework / Database access**: Confirm connection strings are valid and any EF migrations run cleanly with `dotnet ef database update`.
- **Authentication / Authorization**: If the project uses ASP.NET Identity or cookie-based auth, verify middleware configuration in `Program.cs` or `Startup.cs` follows the current .NET conventions.
- **Static files and wwwroot**: Confirm that static assets (CSS, JS, images) are present in the `wwwroot` folder and are being served correctly.
- **Configuration**: Verify that `appsettings.json` contains all required keys previously held in `Web.config` or `App.config`, as these are not automatically migrated.

### 7. Review Removed or Changed APIs

Check for usage of any APIs that were available in .NET Framework but behave differently or have been replaced in cross-platform .NET:

- `HttpContext.Current` — not available; use dependency-injected `IHttpContextAccessor` instead.
- `System.Web` namespace — not available in cross-platform .NET.
- `ConfigurationManager` — replaced by `Microsoft.Extensions.Configuration`.

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) if a thorough API compatibility scan is needed.

### 8. Deployment

Once the application has been validated locally:

1. Publish the application using:
   ```bash
   dotnet publish --configuration Release --output ./publish
   ```
2. Verify the contents of the `./publish` folder include all expected assemblies and static assets.
3. Deploy the contents of the `./publish` folder to your target hosting environment (IIS, Azure App Service, Linux server, etc.).
4. For IIS hosting, ensure the **ASP.NET Core Hosting Bundle** is installed on the server and the site is configured to use an **in-process** or **out-of-process** hosting model as appropriate.