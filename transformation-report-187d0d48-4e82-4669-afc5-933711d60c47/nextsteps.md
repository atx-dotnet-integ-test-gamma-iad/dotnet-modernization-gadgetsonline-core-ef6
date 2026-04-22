# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Verify that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, ensure it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET compared to .NET Framework. Review the following areas manually:

- **Windows-specific APIs**: Any usage of `System.Web`, `HttpContext`, or Windows Registry should be replaced with their cross-platform equivalents.
- **Configuration**: Ensure `Web.config` or `App.config` settings have been migrated to `appsettings.json` and are being read via `IConfiguration`.
- **Authentication/Authorization**: If the project uses ASP.NET Membership or `FormsAuthentication`, these need to be replaced with ASP.NET Core Identity or cookie authentication middleware.

### 5. Run the Application Locally

Start the application using the .NET CLI:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate to the URL shown in the console output and verify that the application loads and core functionality works as expected.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate functional correctness:

```bash
dotnet test
```

Review the test results and address any failing tests before proceeding.

### 7. Review Static Files and Bundling

If the project uses static assets (CSS, JavaScript, images), confirm that:

- Static files are located in the `wwwroot` folder.
- Any legacy bundling via `BundleConfig.cs` has been replaced with a supported approach such as LibMan or a front-end build tool.

### 8. Verify Database Connectivity

If the project uses Entity Framework, confirm the following:

- The connection string in `appsettings.json` is correct.
- The `DbContext` is registered in `Program.cs` or `Startup.cs` via `AddDbContext`.
- Run any pending migrations if applicable:

```bash
dotnet ef database update
```

### 9. Publish the Application

Once validation is complete, publish the application to a target folder:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` folder to confirm all required files are present, then deploy the output to your target hosting environment.